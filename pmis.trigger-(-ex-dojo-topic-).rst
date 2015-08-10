.. _pmis.trigger-(-ex-dojo-topic-):

==============================
pmis.trigger ( ex DOJO Topic )
==============================




!!!! NOT SO GOOD WAY !!!!

_____________________________________________________________________________
mainPage1.jsp:

// I will load detailPage.jsp into my ifrmDetail iframe!!!
// I will load listPage.jsp into my ifrmList iframe!!!
...
<iframe name="ifrmList" ... />
<iframe name="ifrmDetail" ... />

_____________________________________________________________________________
mainPage2.jsp:

// I will load detailPage.jsp into my ifrmDetail iframe!!!
// I don't have an ifrmList!!!
...

_____________________________________________________________________________
listPage.jsp:

function onSelected(){
    // I will set the value of the input seq in my parent, so he can remember my choise! ...but who is my parent? ...he will have an input seq?
    // I will load detail on the ifrmDetail iframe of my parent! ...but who is my parent? ...and the name of the iframe will be ifrmDetail?
}

_____________________________________________________________________________
detailPage.jsp:

function onUpdate() {
    // I will refresh the list on my parent into the ifrmList iframe! ...but who is my parent? ...and the name of the iframe will be ifrmList?
} 

!!!! MORE GOOD WAY !!!!
_____________________________________________________________________________
mainPage1.jsp:

// I will load detailPage.jsp into my ifrmDetail iframe!!!
// I will load a list into my ifrmList iframe!!!

...
<iframe name="ifrmList" ... />
<iframe name="ifrmDetail" ... />

$(document).on("docu/updated", function(e, data) {
    alert("GOT IT! I will do what I have to do!");
    // I will refresh the list because I know where it is, is on my page!
});
$(document).on("docu/selected", function(e, data) {
    alert("GOT IT! I will do what I have to do!");
    // I set the seq from data.seq into my input seq and then I will load detail in ifrmDetail iframe because I know where it is, is on my page!
});

_____________________________________________________________________________
mainPage2.jsp:

// I will load detailPage.jsp into my ifrmDetail iframe!!!
// After detail update I don't want to do nothing!

...
<iframe name="ifrmDetail" ... />

_____________________________________________________________________________
listPage.jsp:

function onSelected(){
    pmis.trigger('docu/selected', { "seq": selectedSeq });
}

______________________________________________________________________________
detailPage.jsp:

function onUpdate() {
    pmis.trigger('docu/updated', { "seq" : myseq });
}
    
