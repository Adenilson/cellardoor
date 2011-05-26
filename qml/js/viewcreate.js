var component;
var mView;

function create() {
    //Assumes that the file can be in a network (so I believe
    //that it will have an async behavior)
    component = Qt.createComponent("View.qml");

    if (component.status == Component.Ready) {
	finishCreation();

    } else {
	component.statusChanged.connect(finishCreation);
    }
}

function finishCreation() {

    if (component.status == Component.Ready) {

	mView = component.createObject(appWindow);
	if (mView == null) {
	    console.log("Failed object creation!");

	} else {
	    //Show it in animated way
	}
    }

}
