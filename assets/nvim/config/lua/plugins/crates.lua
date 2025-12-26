local crates = require("crates")
local opts = { silent = true }
return {
	"saecki/crates.nvim",
	keys = {
		{ "n", "<leader>Ct", crates.toggle, opts },
		{ "n", "<leader>Cr", crates.reload, opts },

		{ "n", "<leader>Cv", crates.show_versions_popup, opts },
		{ "n", "<leader>Cf", crates.show_features_popup, opts },
		{ "n", "<leader>Cd", crates.show_dependencies_popup, opts },

		{ "n", "<leader>Cu", crates.update_crate, opts },
		{ "v", "<leader>Cu", crates.update_crates, opts },
		{ "n", "<leader>Ca", crates.update_all_crates, opts },
		{ "n", "<leader>CU", crates.upgrade_crate, opts },
		{ "v", "<leader>CU", crates.upgrade_crates, opts },
		{ "n", "<leader>CA", crates.upgrade_all_crates, opts },

		{ "n", "<leader>Cx", crates.expand_plain_crate_to_inline_table, opts },
		{ "n", "<leader>CX", crates.extract_crate_into_table, opts },

		{ "n", "<leader>CH", crates.open_homepage, opts },
		{ "n", "<leader>CR", crates.open_repository, opts },
		{ "n", "<leader>CD", crates.open_documentation, opts },
		{ "n", "<leader>CC", crates.open_crates_io, opts },
		{ "n", "<leader>CL", crates.open_lib_rs, opts },
	},
}
