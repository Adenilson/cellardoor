function WidgetLoader()
{
    this.component;
    this.mView;

    this.create = function(qmlfile) {
	//Assumes that the file can be in a network (so I believe
	//that it will have an async behavior)
	this.component = Qt.createComponent(qmlfile);

	if (this.component.status == Component.Ready) {
	    this.finishCreation();

	} else {
	    this.component.statusChanged.connect(finishCreation);
	}
    }

    this.finishCreation = function() {

	if (this.component.status == Component.Ready) {

	    this.mView = this.component.createObject(appWindow);
	    if (this.mView == null) {
		console.log("Failed object creation!");

	    } else {
		//Show it in animated way
	    }
	}

    }
}

