;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http\:\/\/|ftp\:\/\/|https\:\/\/|ftps\:\/\/|file\:\/\/|telnet\:\/\/|www\.)([www\.]?)([a-zA-Z0-9\.\-]+)\.(de|net|org|to|com|biz|co|uk|am|pl)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "gftp://HY.org"
(define-fun Witness1 () String (seq.++ "g" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "H" (seq.++ "Y" (seq.++ "." (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))))))))))))
;witness2: "telnet://fGa.am"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "G" (seq.++ "a" (seq.++ "." (seq.++ "a" (seq.++ "m" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.union (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))))) (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." "")))))))))))(re.++ (re.opt (re.union (re.range "." ".") (re.range "w" "w")))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") (re.union (str.to_re (seq.++ "d" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "t" (seq.++ "o" "")))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))(re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "z" ""))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" "")))(re.union (str.to_re (seq.++ "u" (seq.++ "k" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" ""))) (str.to_re (seq.++ "p" (seq.++ "l" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
