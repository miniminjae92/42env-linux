-- return {
-- 	"stevearc/conform.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	config = function()
-- 		local conform = require("conform")
--
-- 		conform.setup({
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				c = { "forty_two" },
-- 				cpp = { "forty_two" },
-- 			},
-- 			formatters = {
-- 				forty_two = {
-- 					command = vim.fn.expand("~/.local/bin/c_formatter_42"),
-- 					args = { "$FILENAME" },
-- 					stdin = false,
-- 				},
-- 			},
-- 			format_on_save = {
-- 				lsp_fallback = true,
-- 				async = false,
-- 				timeout_ms = 1000,
-- 			},
-- 		})
--
-- 		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
-- 			conform.format({
-- 				lsp_fallback = true,
-- 				async = false,
-- 				timeout_ms = 1000,
-- 			})
-- 		end, { desc = "Format file or range (in visual mode)" })
-- 	end,
-- }

-- ~/.config/nvim/lua/plugins/formatting.lua
-- return {
-- 	"stevearc/conform.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	config = function()
-- 		local conform = require("conform")
--
-- 		conform.setup({
-- 			formatters_by_ft = {
-- 				c = { "forty_two" },
-- 				cpp = { "forty_two" },
-- 			},
-- 			formatters = {
-- 				forty_two = {
-- 					command = vim.fn.expand("~/.local/bin/c_formatter_42"),
-- 					-- ▲ 실행 파일
-- 					args = {
-- 						"--style=file", -- 외부 파일 사용 선언
-- 						"--assume-filename", -- 다음 인자를 스타일 파일로 인식
-- 						vim.fn.expand("~/.clang-format"),
-- 						"$FILENAME", -- 마지막에 실제 포맷 대상
-- 					},
-- 					stdin = false,
-- 					env = { -- 혹시 모를 fallback 방지
-- 						CLANG_FORMAT_STYLE = "file",
-- 					},
-- 				},
-- 			},
-- 			format_on_save = {
-- 				lsp_fallback = true,
-- 				timeout_ms = 1000,
-- 			},
-- 			log_level = vim.log.levels.ERROR, -- 필요 시 DEBUG로 올려서 추적
-- 		})
-- 	end,
-- }


return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c   = { "forty_two" },
				cpp = { "forty_two" },
			},
			formatters = {
				forty_two = {
					command = vim.fn.expand("~/.local/bin/c_formatter_42"),
					args    = { "$FILENAME" },
					stdin   = false,
				},
			},
			format_on_save = false
		})
		vim.keymap.set("n", "<leader>F", function()
		vim.cmd("w")
		conform.format({ async = true, lsp_fallback = true })
		end, { desc = "Save and format" })
	end,
}
