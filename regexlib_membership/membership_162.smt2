;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http\:\/\/|ftp\:\/\/|https\:\/\/|ftps\:\/\/|file\:\/\/|telnet\:\/\/|www\.)([www\.]?)([a-zA-Z0-9\.\-]+)\.(de|net|org|to|com|biz|co|uk|am|pl)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "gftp://HY.org"
(define-fun Witness1 () String (str.++ "g" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "H" (str.++ "Y" (str.++ "." (str.++ "o" (str.++ "r" (str.++ "g" ""))))))))))))))
;witness2: "telnet://fGa.am"
(define-fun Witness2 () String (str.++ "t" (str.++ "e" (str.++ "l" (str.++ "n" (str.++ "e" (str.++ "t" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "f" (str.++ "G" (str.++ "a" (str.++ "." (str.++ "a" (str.++ "m" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))(re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.union (str.to_re (str.++ "t" (str.++ "e" (str.++ "l" (str.++ "n" (str.++ "e" (str.++ "t" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))))) (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." "")))))))))))(re.++ (re.opt (re.union (re.range "." ".") (re.range "w" "w")))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") (re.union (str.to_re (str.++ "d" (str.++ "e" "")))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "t" (str.++ "o" "")))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))(re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "z" ""))))(re.union (str.to_re (str.++ "c" (str.++ "o" "")))(re.union (str.to_re (str.++ "u" (str.++ "k" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" ""))) (str.to_re (str.++ "p" (str.++ "l" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
