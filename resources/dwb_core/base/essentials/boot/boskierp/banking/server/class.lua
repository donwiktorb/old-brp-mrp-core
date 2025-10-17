Bank = class(false, false, false, User)

function Bank:Load()
  self.account = Mysql.Sync:fetchAll("SELECT * FROM bank_accounts WHERE bankId = ?", {
    self.charId,
  })[1]
  if not self.account or not self.account.bankId then
    Mysql.Async:Insert("INSERT INTO bank_accounts SET ?", {
      bankId = self.charId,
      balance = Config.StartBankMoney,
    }, function(rowId)
      self.account = {
        bankId = self.charId,
        id = rowId,
        balance = Config.StartBankMoney,
      }
    end)
  end
end

function Bank:Save()
  Mysql.Async:Execute("REPLACE INTO bank_accounts SET ?", {
    id = self.account.id,
    bankId = self.account.bankId,
    balance = self.account.balance,
  })
end

function Bank:Deposit(value)
  if self.inventory:RemoveItem(Config.Items.Money, "name", value) then
    self:Add(value)
    return true
  end
end

function Bank:Withdraw(value)
  if self.account.balance >= value then
    self:Remove(value)
    self.inventory:AddItem({
      name = Config.Items.Money,
      count = value,
    })
    return true
  end
end

function Bank:Add(value)
  self.account.balance = self.account.balance + value
end

function Bank:Remove(value)
  self.account.balance = self.account.balance - value
end

function Bank:Transaction(type, by, reason, value)
  if type == 1 then
    self:ShowNotify("bank", TR("bank_add", by, reason, value))
    self:Add(value)
    Mysql.Async:Insert("INSERT INTO bank_transactions SET ?", {
      id = 0,
      bankId = self.charId,
      by = by,
      reason = reason,
      price = value,
      type = "in",
      time = os.time(),
    }, function(rowsChanged)
      Log:Info("Update bank for ", self.source)
    end)
  else
    self:ShowNotify("info", "bank", TR("bank_remove", by, reason, value))
    self:Remove(value)
    Mysql.Async:Insert("INSERT INTO bank_transactions SET ?", {
      id = 0,
      bankId = self.charId,
      by = by,
      reason = reason,
      price = value,
      type = "out",
      time = os.time(),
    }, function(rowsChanged)
      Log:Info("Update bank for ", self.source)
    end)
  end
end

function Bank:Unload()
  self:Save()
end

function Bank:Open(open)
  local bankData = self.account

  local transactions = Mysql.Sync:fetchAll(
    "SELECT *, time*1000 as time FROM bank_transactions WHERE bankId = ? ORDER BY time DESC",
    {
      self.charId,
    }
  )

  local data = {
    fullName = self.char.data.firstname .. " " .. self.char.data.lastname,
    name = "bank",
    balance = bankData.balance,
    bankId = self.charId,
    transactions = transactions,
    avatar = self.char.data.avatar,
    page = "in",
  }

  Event:TriggerNet("dwb:bank:open", self.source, data, open)
end

User:OnLoadedChar(function(self)
  self.bank = Bank(self)
  self.bank:Load()
end)

User:OnUnloadedChar(function(self)
  self.bank:Unload()
  self.bank = false
end)

