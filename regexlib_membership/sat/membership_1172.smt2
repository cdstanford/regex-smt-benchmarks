;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((file|gopher|news|nntp|telnet|http|ftp|https|ftps|sftp)://)|(www\.))+(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(/[a-zA-Z0-9\&amp;%_\./-~-]*)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "G\u0098http://telnet://ftp://gopher://ftp://ftp://gopher://nntp://ftps://http://sftp://gopher://telnet://https://sftp://sftp://news://news://sftp://ftps://nntp://nntp://http://gopher://ftp://nntp://https://news://gopher://news://nntp://www.telnet://https://www.ftps://file://telnet://https://nntp://ftp://https://5.3.809.61"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "\x98" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "5" (seq.++ "." (seq.++ "3" (seq.++ "." (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "." (seq.++ "6" (seq.++ "1" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "telnet://gopher://sftp://https://ftp://nntp://ftps://ftp://http://www.http://www.news://ftps://https://sftp://https://http://gopher://www.ftp://www.https://https://http://telnet://nntp://ftps://ftp://http://ftp://telnet://ftp://www.sftp://news://www.ftp://telnet://nntp://news://telnet://ftps://gopher://file://telnet://www.news://file://ftp://sftp://www.sftp://file://file://ftps://news://gopher://a.Jt"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "a" (seq.++ "." (seq.++ "J" (seq.++ "t" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.++ (re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" "")))))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" "")))))(re.union (str.to_re (seq.++ "n" (seq.++ "n" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" "")))))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" ""))))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" ""))))) (str.to_re (seq.++ "s" (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))))))))))))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))) (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." "")))))))(re.++ (re.union (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))))))))) (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "&") (re.range "-" "~")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)