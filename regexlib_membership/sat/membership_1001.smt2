;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = UploadFriendly is an easy to use Java Applet that will allow multiple file uploads on a web server in a web page. The control supports file filtering, limits and more. Samples available in the following languages: ASP, ASP.NET, PHP, Coldfusion and JSP
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x11UploadFriendly is an easy to use Java Applet that will allow multiple file uploads on a web server in a web page\u00D7 The control supports file filtering, limits and more  Samples available in the following languages: ASP, ASP\x10NET, PHP, Coldfusion and JSP\u00E3B\u00C9h=r"
(define-fun Witness1 () String (str.++ "\u{11}" (str.++ "U" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "F" (str.++ "r" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "d" (str.++ "l" (str.++ "y" (str.++ " " (str.++ "i" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ " " (str.++ "e" (str.++ "a" (str.++ "s" (str.++ "y" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ " " (str.++ "J" (str.++ "a" (str.++ "v" (str.++ "a" (str.++ " " (str.++ "A" (str.++ "p" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "t" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "a" (str.++ "t" (str.++ " " (str.++ "w" (str.++ "i" (str.++ "l" (str.++ "l" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "m" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "i" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "v" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ "\u{d7}" (str.++ " " (str.++ "T" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "c" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ "r" (str.++ "o" (str.++ "l" (str.++ " " (str.++ "s" (str.++ "u" (str.++ "p" (str.++ "p" (str.++ "o" (str.++ "r" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "," (str.++ " " (str.++ "l" (str.++ "i" (str.++ "m" (str.++ "i" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "r" (str.++ "e" (str.++ " " (str.++ " " (str.++ "S" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "v" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "l" (str.++ "a" (str.++ "n" (str.++ "g" (str.++ "u" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ "s" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" (str.++ "," (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" (str.++ "\u{10}" (str.++ "N" (str.++ "E" (str.++ "T" (str.++ "," (str.++ " " (str.++ "P" (str.++ "H" (str.++ "P" (str.++ "," (str.++ " " (str.++ "C" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ "f" (str.++ "u" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "J" (str.++ "S" (str.++ "P" (str.++ "\u{e3}" (str.++ "B" (str.++ "\u{c9}" (str.++ "h" (str.++ "=" (str.++ "r" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "UploadFriendly is an easy to use Java Applet that will allow multiple file uploads on a web server in a web page\u00E7 The control supports file filtering, limits and more\u00BA Samples available in the following languages: ASP, ASP-NET, PHP, Coldfusion and JSP"
(define-fun Witness2 () String (str.++ "U" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "F" (str.++ "r" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "d" (str.++ "l" (str.++ "y" (str.++ " " (str.++ "i" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ " " (str.++ "e" (str.++ "a" (str.++ "s" (str.++ "y" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ " " (str.++ "J" (str.++ "a" (str.++ "v" (str.++ "a" (str.++ " " (str.++ "A" (str.++ "p" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "t" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "a" (str.++ "t" (str.++ " " (str.++ "w" (str.++ "i" (str.++ "l" (str.++ "l" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "m" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "i" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "v" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ "\u{e7}" (str.++ " " (str.++ "T" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "c" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ "r" (str.++ "o" (str.++ "l" (str.++ " " (str.++ "s" (str.++ "u" (str.++ "p" (str.++ "p" (str.++ "o" (str.++ "r" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "," (str.++ " " (str.++ "l" (str.++ "i" (str.++ "m" (str.++ "i" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "r" (str.++ "e" (str.++ "\u{ba}" (str.++ " " (str.++ "S" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "v" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "l" (str.++ "a" (str.++ "n" (str.++ "g" (str.++ "u" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ "s" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" (str.++ "," (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" (str.++ "-" (str.++ "N" (str.++ "E" (str.++ "T" (str.++ "," (str.++ " " (str.++ "P" (str.++ "H" (str.++ "P" (str.++ "," (str.++ " " (str.++ "C" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ "f" (str.++ "u" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "J" (str.++ "S" (str.++ "P" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "U" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "F" (str.++ "r" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "d" (str.++ "l" (str.++ "y" (str.++ " " (str.++ "i" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ " " (str.++ "e" (str.++ "a" (str.++ "s" (str.++ "y" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ " " (str.++ "J" (str.++ "a" (str.++ "v" (str.++ "a" (str.++ " " (str.++ "A" (str.++ "p" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "t" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "a" (str.++ "t" (str.++ " " (str.++ "w" (str.++ "i" (str.++ "l" (str.++ "l" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "m" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "i" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "v" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "a" (str.++ " " (str.++ "w" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "g" (str.++ "e" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ " " (str.++ "T" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "c" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ "r" (str.++ "o" (str.++ "l" (str.++ " " (str.++ "s" (str.++ "u" (str.++ "p" (str.++ "p" (str.++ "o" (str.++ "r" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "," (str.++ " " (str.++ "l" (str.++ "i" (str.++ "m" (str.++ "i" (str.++ "t" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "r" (str.++ "e" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ " " (str.++ "S" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "a" (str.++ "v" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "i" (str.++ "n" (str.++ " " (str.++ "t" (str.++ "h" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "l" (str.++ "a" (str.++ "n" (str.++ "g" (str.++ "u" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ "s" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" (str.++ "," (str.++ " " (str.++ "A" (str.++ "S" (str.++ "P" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "N" (str.++ "E" (str.++ "T" (str.++ "," (str.++ " " (str.++ "P" (str.++ "H" (str.++ "P" (str.++ "," (str.++ " " (str.++ "C" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ "f" (str.++ "u" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "J" (str.++ "S" (str.++ "P" "")))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
