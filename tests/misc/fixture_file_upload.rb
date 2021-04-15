ChangeVariable = fixture_file_upload(Rails.root.join('test/fixtures/files', 'ChangeFileName.ChangeFileNameExtension'), 'ChangeFileType/ChangeFileSubType')
# DeleteThisPls - file subtypes:
#   application/pdf
#   video/mov
#   etc.
@ChangeInstance.ChangeAttachment.attach(ChangeVariable)
