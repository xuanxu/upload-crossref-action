# Open Journals :: Upload crossref.xml file

This action adds a crossref.xml file to a paper branch in the corresponding Open Journal's papers repository

## Usage

Usually this action is used as a step in a workflow after the pdf file and the paper's branch are created.

### Inputs

The action accepts the following inputs:

- **pdf_path**: Required. The path to the pdf file with the crossref data
- **papers_repo**: Required. The repository containing the published and submitted papers in `owner/reponame` format.
- **issue_id**: Required. The issue number of the submission of the paper.
- **bot_token**: Required. The access token to be used to upload files, usually a bot account.
- **branch_prefix**: Optional. The prefix of the name of the paper's branch.

### Outputs

If the action runs successfully it generates two outpus:

- **html_url**: The HTML URL for the new crossref file
- **download_url**: The direct download URL for the created crossref file

### Example

Use it adding it as a step in a workflow `.yml` file in your repo's `.github/workflows/` directory and passing your custom input values (here's an example showing how to pass input values from diferent sources: workflow inputs, secrets or directly).

````yaml
on:
  workflow_dispatch:
   inputs:
      issue_id:
        description: 'The issue number of the submission'
jobs:
  processing:
    runs-on: ubuntu-latest
    steps:
      - name: Upload file to papers repo
        uses: xuanxu/upload-crossref-action@main
        with:
          papers_repo: myorg/myjournal-papers
          branch_prefix: myjournal
          issue_id: ${{ github.event.inputs.issue_id }}
          pdf_path: docs/paper.pdf
          bot_token: ${{ secrets.BOT_ACCESS_TOKEN }}
```
