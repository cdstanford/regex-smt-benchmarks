;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.[a-zA-Z]{2,4})(\:[0-9]+)?(/[^/][a-zA-Z0-9\.\,\?\'\\/\+&amp;%\$#\=~_\-@]*)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "https://253.10.099.4:87"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "2" (seq.++ "5" (seq.++ "3" (seq.++ "." (seq.++ "1" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "4" (seq.++ ":" (seq.++ "8" (seq.++ "7" ""))))))))))))))))))))))))
;witness2: "ftp://89e-YzAE@9.251.8.8:9/i"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "8" (seq.++ "9" (seq.++ "e" (seq.++ "-" (seq.++ "Y" (seq.++ "z" (seq.++ "A" (seq.++ "E" (seq.++ "@" (seq.++ "9" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "1" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ ":" (seq.++ "9" (seq.++ "/" (seq.++ "i" "")))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" "")))))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" ""))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range ":" ":") (re.+ (re.union (re.range "$" "&")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (re.range "@" "@"))))(re.++ (re.union (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "1" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".") (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))))))))) (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.union (re.range "\x00" ".") (re.range "0" "\xff")) (re.* (re.union (re.range "#" "'")(re.union (re.range "+" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
