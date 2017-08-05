module ReddFactories
  def build_redd_submission(attrs = {})
    Redd::Models::Submission.new(
      nil,
      {
        title: "Super title",
        author: "userx",
        permalink: "/a",
        url: "http://ab.cd/e",
        subreddit_name_prefixed: "r/aww"
      }.merge(attrs)
    )
  end
end
