hunspell-vi
===========

<table>
<tr>
<th>English</th><th>Tiếng Việt</th>
</tr>
<tr>
<td>hunspell-vi is a set of mature spell checking dictionaries for the Vietnamese language that are compatible with the <a href="http://hunspell.sourceforge.net/">Hunspell</a> spell checking engine. Prepackaged add-ons are available for <a href="https://www.mozilla.org/en-US/">Mozilla</a>-based applications (<a href="https://www.mozilla.org/en-US/firefox/">Firefox</a>, <a href="https://www.mozilla.org/en-US/thunderbird/">Thunderbird</a>, <a href="http://www.seamonkey-project.org/">SeaMonkey</a>, <a href="http://www.instantbird.com/">Instantbird</a>, etc.), <a href="http://www.openoffice.org/">Apache OpenOffice</a>, and <a href="https://www.libreoffice.org/">LibreOffice</a>.</td>
<td>hunspell-vi là bộ từ điển kiểm tra chính tả tiếng Việt ổn định dành cho trình kiểm tra chính tả <a href="http://hunspell.sourceforge.net/">Hunspell</a>. Các tiện ích có sẵn cho các ứng dụng thuộc hệ <a href="https://www.mozilla.org/vi/">Mozilla</a> (<a href="https://www.mozilla.org/vi/firefox/">Firefox</a>, <a href="https://www.mozilla.org/vi/thunderbird/">Thunderbird</a>, <a href="http://www.seamonkey-project.org/">SeaMonkey</a>, <a href="http://www.instantbird.com/">Instantbird</a>, v.v.), <a href="http://www.openoffice.org/vi/">Apache OpenOffice</a>, và <a href="https://vi.libreoffice.org/">LibreOffice</a>.</td>
</tr>
<tr>
<td>The Mozilla add-on features two dictionaries: one that prefers the traditional style of accent marks more common abroad (e.g., <i>xóa</i>), and one that prefers the reformed style more common in Vietnam (<i>xoá</i>). The OpenOffice add-on only includes the reformed dictionary.</td>
<td>Tiện ích Mozilla cung cấp hai từ điển: một từ điển đặt dấu theo kiểu truyền thống và hải ngoại (vd: <i>xóa</i>), còn từ điển kia tuân theo kiểu cải cách phổ biến hơn tại Việt Nam (<i>xoá</i>). Tiện ích OpenOffice chỉ cung cấp từ điển kiểu cải cách.</td>
</tr>
<tr>
<td>The word lists do not attempt to cover compound words, only the monosyllabic words that can be compounded. In contemporary Vietnamese, compound words consist of monosyllabic words joined by spaces. Without a statistical model, Hunspell is incapable of distinguishing the spaces inside compound words from those surrounding them.</td>
<td>Các danh sách từ ngữ không có mục đích bao gồm các từ ghép, chỉ có các từ đơn âm có thể được ghép lại. Trong tiếng Việt hiện đại, các từ ghép có những từ đơn âm được ghép lại bằng dấu cách. Vì thiếu một mô hình thống kê, Hunspell không có khả năng phân biệt những dấu cách bên trong từ ghép với những dấu cách nằm chung quanh từ ghép.</td>
</tr>
<tr>
<td align="center" colspan="2"><h2>Mozilla, Firefox, Thunderbird…</h2></td>
</tr>
<tr>
<td>Install the <a href="https://addons.mozilla.org/en-US/firefox/addon/vietnamese-dictionary/?src=external-github">Vietnamese Dictionary add-on</a> (no restart needed), right-click on a text box, and select “Vietnamese (DauCu)” or “Vietnamese (DauMoi)” from Languages in the context menu. Please remember to write a review at <a href="https://addons.mozilla.org/firefox/addon/vietnamese-dictionary/?src=external-github">Mozilla Add-ons</a>. Note that the <a href="https://www.mozilla.org/en-US/firefox/all/?q=vietnamese">Vietnamese versions of Firefox</a> and <a href="https://www.mozilla.org/en-US/thunderbird/all.html#vi">Thunderbird</a> come with an outdated version of this add-on.</td>
<td>Cài đặt <a href="https://addons.mozilla.org/vi/firefox/addon/vietnamese-dictionary/?src=external-github">tiện ích Từ điển tiếng Việt</a> (không cần khởi động lại), nhấn chuột phải vào một hộp văn bản, và chọn “Việt (DauCu)” hoặc “Việt (DauMoi)” từ Ngôn ngữ trong trình đơn. Xin hãy nhớ đánh giá tại <a href="https://addons.mozilla.org/vi/firefox/addon/vietnamese-dictionary/?src=external-github">Tiện ích Mozilla</a>. Lưu ý rằng <a href="https://www.mozilla.org/vi/firefox/all/?q=vietnamese">các bản tiếng Việt của Firefox</a> và <a href="https://www.mozilla.org/vi/thunderbird/all.html#vi">Thunderbird</a> có một phiên bản cũ của tiện ích này.</td>
</tr>
<tr>
<td align="center" colspan="2"><h2>OpenOffice.org</h2></td>
</tr>
<tr>
<td>For OpenOffice.org 3.<i>x</i> and above, install the <a href="http://extensions.openoffice.org/en/project/Vietnamese_SpellChecker">Vietnamese SpellChecker extension</a>. For OpenOffice.org 2.3, see the <a href="https://github.com/1ec5/hunspell-vi/wiki/Installation">installation instructions</a>.</td>
<td>OpenOffice.org 3.<i>x</i> trở lên thì cài đặt <a href="http://extensions.openoffice.org/en/project/Vietnamese_SpellChecker">phần mở rộng Vietnamese SpellChecker</a>. OpenOffice.org 2.3 thì xem <a href="https://github.com/1ec5/hunspell-vi/wiki/C%C3%A0i-%C4%91%E1%BA%B7t">hướng dẫn cài đặt</a>.</td>
</tr>
<tr>
<td align="center"><h2>History</h2></td>
<td align="center"><h2>Lịch sử</h2></td>
</tr>
<tr>
<td>This project has its origins in the <a href="http://aspell.net/">GNU Aspell</a> 0.60 <a href="http://ftp.gnu.org/gnu/aspell/dict/vi/aspell6-vi-0.01.1-1.tar.bz2">Vietnamese Dictionary Package, version 0.01.1-1</a>, which include a word list from the <a href="http://www.informatik.uni-leipzig.de/~duc/Dict/">Free Vietnamese Dictionary Project</a> maintained by Hồ Ngọc Đức. The Aspell dictionary was ported to the <a href="http://hunspell.sourceforge.net/">Hunspell</a> format by that project’s maintainer, László Németh. Ivan Garcia and Minh Nguyễn made many corrections and packaged the resulting dictionaries into add-ons for major Hunspell client software.</td>
<td>Dự án này xuất phát từ <a href="http://ftp.gnu.org/gnu/aspell/dict/vi/aspell6-vi-0.01.1-1.tar.bz2">Gói Từ điển Việt ngữ, phiên bản 0.01.1-1</a> dành cho <a href="http://aspell.net/">GNU Aspell</a> 0.60, gói này cung cấp danh sách từ ngữ của <a href="http://www.informatik.uni-leipzig.de/~duc/Dict/">Dự án Từ điển tiếng Việt miễn phí</a> do Hồ Ngọc Đức bảo quản. Từ điển Aspell được chuyển đổi qua dạng <a href="http://hunspell.sourceforge.net/">Hunspell</a> bởi người bảo quản dự án đó, László Németh. Ivan Garcia và Nguyễn Xuân Minh chỉnh sửa nhiều thứ và gói lại các từ điển thành tiện ích cho những phần mềm phổ biến dùng Hunspell.</td>
</tr>
</table>
