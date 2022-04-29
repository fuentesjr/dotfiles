local M = {}

function M.get_sections()
  local header = {
    type = "text",
    val = {
      "@@@@@@@@@@@@@@@@@@88@@@@@@@@@@@@@@@@@@@@@@@@@80CLC8@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@81;;itL0@@888888888888888880L1;,,,L@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@C,,,:ifC0000000GGGG000000000GGCf1:i8@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@L,:tC000000000GGGG00000000000000GCt8@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@G1C00000000000GGGG0000000000000000GG08@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@880000000GGCCCGCGGG00GGCCLCCGG000000GCG8@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@800000GLti;:::::;i1tti;:,,,,,:;1LG0000GGG008@@@@@@@@@@@@",
      "@@@@@@@@@@88000000Gf;,...,,,,,...,..,,,,,,,,,.,;L000GLfLCG0@@@@@@@@@@@",
      "@@@@@@@@@8GCLfG0GCi,,:;11ttttt1111tttffffLffti,.,f00GfttLG08@@@@@@@@@@",
      "@@@@@@@@@0GLttCGCi.:tCGG0000000GGG0GGGGGGGGGGGLi,:G00GCCG00G8@@@@@@@@@",
      "@@@@@@@@@80GCGGGL,:LG00GGCG0GGGGGGGGGGGGCCLGGGGCi,f00CLLCGGGG0@@@@@@@@",
      "@@@@@@@@0GGLfLCGf,10G08CLtt00GGGGGGGGG8Ctt1L0GGGt,f0CttttLCGGG8@@@@@@@",
      "@@@@@@@80CLtttfGC,10G0@L11t00GGGGGGGGG00t1tC0GGGt,L0CttttLCGGG0888888@",
      "@88888800GCLttfGG1:C0008GC00GGGGCLGGGGG00GG0GGGC:;GGGCLLCGGGG08888888@",
      "@888888000GGGGGGGC::fG00000GGGGGGLGGGGGGGGGGGGf;,;iiG8800008@@@@@@888@",
      "@888@@@@@@@8888888C1;;1fLCGGGGGGGGCGGGCCCCLf1;,,:iL8@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@0Cf1iiiiiiiiiiii;;;;::::itfC0@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@880GLf1;ifLf1,,:ii;iif0@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@8fCti;::i111;:::i;:;::18@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@C,;::;::::::::::iff1;tG@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@1,,;fLft11tfLfi,:;fG@@@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@GitLfGCfLtL00Gf:,.t@@@@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@0f1:,1LLiii;;::C@@@@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@C1,,,f8f,,.itC@@@@@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@G;1:,,,1L:,,;t0@@@@@@@@@@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@88880000t;1i;;;ifi,,,.;G00008888@@@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@000000000Gfttt11fG0GfttfLG0000000008@@@@@@@@@@@@@@@@",
      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
      "       ______   __    __       ______             __           ",
      "       /      \\ /  |  /  |     /      \\           /  |          ",
      "      /$$$$$$  |$$/  _$$ |_   /$$$$$$  |  ______  $$/  _______  ",
      "      $$ | _$$/ /  |/ $$   |  $$ |  $$/  /      \\ /  |/       \\ ",
      "      $$ |/    |$$ |$$$$$$/   $$ |      /$$$$$$  |$$ |$$$$$$$  |",
      "      $$ |$$$$ |$$ |  $$ | __ $$ |   __ $$ |  $$ |$$ |$$ |  $$ |",
      "      $$ \\__$$ |$$ |  $$ |/  |$$ \\__/  |$$ \\__$$ |$$ |$$ |  $$ |",
      "      $$    $$/ $$ |  $$  $$/ $$    $$/ $$    $$/ $$ |$$ |  $$ |",
      "       $$$$$$/  $$/    $$$$/   $$$$$$/   $$$$$$/  $$/ $$/   $$/ ",
    },
    opts = {
      position = "center",
      hl = "Label",
    },
  }

  local text = require "lvim.interface.text"
  local git_utils = require "lvim.utils.git"

  local current_branch = git_utils.get_lvim_branch()

  local lvim_version
  if current_branch ~= "HEAD" or "" then
    lvim_version = current_branch .. "-" .. git_utils.get_lvim_current_sha()
  else
    lvim_version = "v" .. git_utils.get_lvim_tag()
  end

  local footer = {
    type = "text",
    val = text.align_center({ width = 0 }, {
      "",
      "",
      lvim_version,
    }, 0.5),
    opts = {
      position = "center",
      hl = "Number",
    },
  }

  local buttons = {
    entries = {
      { "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
      { "SPC n", "  New File", "<CMD>ene!<CR>" },
      { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
      { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
      { "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
      {
        "SPC L c",
        "  Configuration",
        "<CMD>edit " .. require("lvim.config").get_user_config_path() .. " <CR>",
      },
    },
  }

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end

return M
