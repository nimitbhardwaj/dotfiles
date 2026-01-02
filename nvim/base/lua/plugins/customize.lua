return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
                                                                                                    
          ▀███▄   ▀███▀         ██         ▀███▀▀▀██▄                                                   
            ███▄    █           ██           ██   ▀██▄                                                  
            █ ███   █   ▄▄█▀████████         ██   ▄██ ▀███  ▀███ ▀████████▄ ▀████████▄   ▄▄█▀██▀███▄███ 
            █  ▀██▄ █  ▄█▀   ██ ██           ███████    ██    ██   ██    ██   ██    ██  ▄█▀   ██ ██▀ ▀▀ 
            █   ▀██▄█  ██▀▀▀▀▀▀ ██    █████  ██  ██▄    ██    ██   ██    ██   ██    ██  ██▀▀▀▀▀▀ ██     
            █     ███  ██▄    ▄ ██           ██   ▀██▄  ██    ██   ██    ██   ██    ██  ██▄    ▄ ██     
          ▄███▄    ██   ▀█████▀ ▀████      ▄████▄ ▄███▄ ▀████▀███▄████  ████▄████  ████▄ ▀█████▀████▄   
                                                                                                  
                                                                                                
      ]],
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = { silent = true },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {}, -- disable markdownlint entirely
      },
    },
  },
}
