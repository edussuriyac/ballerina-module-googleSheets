# Description
#
# Slides object definition

# Description
#
# + presentationId - Id of the presentation
# + size - size of the slides
# + slides - slides of the presentation
# + title - title of the presentation
public type Slides object{
  
  public string presentationId = "";
  public pageSize size = {};
  public Slide[] slides = [];
  public string title = "";

};

# Description
#
# + height - height of the slide
# + width - width of the slide
public type pageSize record {
  int height=0;
  int width= 0;
};

# Description
#
# + objectId - Id of the slide
# + revisionId - revisionId of the slide
public type Slide record {
    string objectId="";
    string revisionId="";
};
