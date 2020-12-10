function table.count( tbl )
	local c = 0
	for _ in pairs(tbl) do
		c = c + 1
	end
	return c
end

function table.random( tbl )
	--在一个table里面，随机取一个值
	local key_table = {}
	for k in pairs(tbl) do
		table.insert(key_table, k)
	end

	local rand = key_table[RandomInt(1, #key_table)]
end

function table.contains( tbl, val )
	for _,v in pairs(tbl) do
		if v == val then
			return true
		end
	end
end
