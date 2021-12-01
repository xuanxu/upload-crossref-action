require "octokit"

def gh_token
  gh_token_from_env = ENV['BOT_TOKEN'].to_s.strip
  raise "!! ERROR: Invalid GitHub Token" if gh_token_from_env.empty?
  gh_token_from_env
end

def github_client
  @github_client ||= Octokit::Client.new(access_token: gh_token, auto_paginate: true)
end

issue_id = ENV["ISSUE_ID"]
jats_path = ENV["JATS_PATH"]
papers_repo = ENV["PAPERS_REPO"]
branch_prefix = ENV["BRANCH_PREFIX"]

id = "%05d" % issue_id
branch = branch_prefix.empty? ? id.to_s : "#{branch_prefix}.#{id}"
jats_uploaded_path = "#{branch}/10.21105.#{branch}.jats"

gh_response = github_client.create_contents(papers_repo,
                                            jats_uploaded_path,
                                            "Creating 10.21105.#{branch}.jats",
                                            File.open("#{jats_path.strip}").read,
                                            branch: branch)

system("echo '::set-output name=jats_html_url::#{gh_response.content.html_url}'")
system("echo '::set-output name=jats_download_url::#{gh_response.content.download_url}'")