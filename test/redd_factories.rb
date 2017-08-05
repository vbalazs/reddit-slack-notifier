module ReddFactories
  def build_redd_submission(attrs = {})
    Redd::Models::Submission.new(
      nil,
      {
        title: "Super title",
        author: "userx",
        permalink: "/a",
        url: "http://ab.cd/e",
        subreddit_name_prefixed: "r/aww",
        created_utc: 1_490_158_000
      }.merge(attrs)
    )
  end
end
