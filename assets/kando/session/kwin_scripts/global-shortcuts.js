
          if(registerShortcut('Thumb', 'Kando - Thumb', '',
            () => {
              console.log('Kando: Triggered.');
              callDBus('menu.kando.Kando', '/menu/kando/Kando',
                       'menu.kando.Kando', 'trigger', 'Thumb',
                       () => console.log('Kando: Triggered.'));
            }
          )) {
            console.log('Kando: Registered shortcut Thumb');
          } else {
            console.log('Kando: Failed to registered shortcut Thumb');
          }
        

          if(registerShortcut('Copy/Paste', 'Kando - Copy/Paste', '',
            () => {
              console.log('Kando: Triggered.');
              callDBus('menu.kando.Kando', '/menu/kando/Kando',
                       'menu.kando.Kando', 'trigger', 'Copy/Paste',
                       () => console.log('Kando: Triggered.'));
            }
          )) {
            console.log('Kando: Registered shortcut Copy/Paste');
          } else {
            console.log('Kando: Failed to registered shortcut Copy/Paste');
          }
        