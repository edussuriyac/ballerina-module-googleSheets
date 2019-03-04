
function convertToPresentation(json jsonSlide) returns Slides {
    Slides slides = new;
    slides.presentationId = jsonSlide.presentationId.toString();
    slides.size = jsonSlide.size != null
                            ? convertToSize(jsonSlide.size) : {};
    slides.title = jsonSlide.slidetitle.toString();
    slides.slides = jsonSlide.slides != null
                            ? convertToSlides(<json[]>jsonSlide.slides) : [];

    return slides;
}

function convertToSlides(json[] jsonSlides) returns Slide[] {
    int i = 0;
    Slide[] slides = [];
    foreach json jsonSlide in jsonSlides {
        slides[i] = convertToSlide(jsonSlide);
        i = i + 1;
    }
    return slides;
}

function convertToSize(json jsonsize ) returns pageSize{
    pageSize jsonSize = {};
    jsonSize.height=convertToInt(jsonsize.height);
    jsonSize.width=convertToInt(jsonsize.width);
    return jsonSize;
}

function convertToSlide(json jsonSlide) returns Slide {
    Slide slide = {};
    slide.objectId = jsonSlide.objectId.toString();
    return slide;
}



function convertToInt(json jsonVal) returns int {
    string stringVal = jsonVal.toString();
    if (stringVal != "") {
        var intVal = int.convert(stringVal);
        if (intVal is int) {
            return intVal;
        } else {
            error err = error(SLIDES_ERROR_CODE,
                        { message: "Error occurred when converting " + stringVal + " to int"});
            panic err;
        }
    } else {
        return 0;
    }
}
