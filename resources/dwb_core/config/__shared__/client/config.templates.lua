TemplateMT = {}

TemplateMT.__index = TemplateMT

function TemplateMT:Render()
  return self.template
end

function TemplateMT:AddElements(elements, position)
  for k, v in pairs(elements) do
    table.insert(self.template.elements, position[k], v)
  end
end

function TemplateMT:RemoveElement(id)
  table.remove(self.template.elements, id)
end

TemplatesMT = {}

TemplatesMT.__index = TemplatesMT

TemplatesMT.__newindex = function(t, k, v)
  setmetatable(v, TemplateMT)
  rawset(t, k, v)
end

Config.UI.Templates = {}
setmetatable(Config.UI.Templates, TemplatesMT)
