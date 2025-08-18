return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			local ufo = require("ufo")

			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})

			-- keymap 설정
			vim.keymap.set("n", "zR", ufo.openAllFolds) -- Reveal 드러내다 모든 fold 열기
			vim.keymap.set("n", "zM", ufo.closeAllFolds) -- Mask 감추다 모든 fold 닫기
			vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds) -- 특정 종류의 fold 제외하고 열기
			vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- 특정 종류의 fold 제외하고 닫기
		end,
	},
}
