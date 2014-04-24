Then /^google analytics custom vars set by slimmer exist$/ do
  gaq_matcher = %r{
    _gaq.push
      \(\[
        "_setCustomVar",
        \d+,              # index
        "(Section|
          NeedID|
          Organisations|
          WorldLocations|
          Format|
          ResultCount)",  # name
        "[\w,<>|]+",      # value
        \d+               # optional scope
      \]\)
  }x
  @response.body.should =~ gaq_matcher
end
