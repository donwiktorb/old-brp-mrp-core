Timer:Set(function()
    for k,v in pairs(DWB.Players) do
        if v.char then
            for k2,v2 in pairs(v.char.jobs) do
                if v2.salary and v2.salary > 0 then
                local multiplier = v2.data and 1+(v2.data.multi or 0) or 1
                local salary = v2.salary or 2000
                local give = salary*multiplier
                if give > 0 then
                    v.bank:Transaction(1, v2.label, v2.grade_label, give)
                end
                -- v:ShowNotify('salary', TR("job_salary", v2.label), TR("job_salary_amount", Math:Format(give)))
            end
            end
        end
    end
end, 60*1000*15)