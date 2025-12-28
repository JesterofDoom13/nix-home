callDBus('menu.kando.Kando', '/menu/kando/Kando',
               'menu.kando.Kando', 'sendWMInfo',
               workspace.activeWindow ? workspace.activeWindow.caption : "",
               workspace.activeWindow ? workspace.activeWindow.resourceClass : "",
               workspace.cursorPos.x, workspace.cursorPos.y,
               () => {
                 console.log('Kando: Successfully transmitted the data.');
               }
      );
      console.log('Kando: Received data request.');
    