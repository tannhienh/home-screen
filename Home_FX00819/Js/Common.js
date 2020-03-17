/**
  *
  *
  */
function openApp(appPath) {

    // Can't open Map app when changing order apps menu
    // Just open when done button no display
    if (statusBar.editting === false) {

        // Hide edit button if edit button visible
        if (statusBar.isShowEditButton)
            statusBar.isShowEditButton = false

        // Open Map application
        openApplication(appPath)
    }
}


// Determine animation scroll bar to left or right
function determineAnimation()
{
    if (menuArea.moveRight
            && (scrollBar.visualPosition + scrollBar.visualSize) < 1)
        increasePosition.restart()
    else if (!menuArea.moveRight
             && (scrollBar.visualPosition >= scrollBar.stepValue))
        decreasePosition.restart()
}
