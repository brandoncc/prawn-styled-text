require 'prawn'
require 'prawn-styled-text'
require 'oga'

Prawn::Font::AFM.hide_m17n_warning = true

pdf = Prawn::Document.new
pdf.styled_text File.read( 'dynamic_br.html' )
pdf.render_file 'test.pdf'

module PrawnStyledText
  @@dynamic_br_tags = true
end

pdf2 = Prawn::Document.new
pdf2.styled_text File.read( 'dynamic_br.html' )
pdf2.render_file 'test2.pdf'
