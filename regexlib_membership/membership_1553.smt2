;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.[a-zA-Z]{2,4})(\:[0-9]+)?(/[^/][a-zA-Z0-9\.\,\?\'\\/\+&amp;%\$#\=~_\-@]*)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://253.10.099.4:87"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "2" (str.++ "5" (str.++ "3" (str.++ "." (str.++ "1" (str.++ "0" (str.++ "." (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "4" (str.++ ":" (str.++ "8" (str.++ "7" ""))))))))))))))))))))))))
;witness2: "ftp://89e-YzAE@9.251.8.8:9/i"
(define-fun Witness2 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "8" (str.++ "9" (str.++ "e" (str.++ "-" (str.++ "Y" (str.++ "z" (str.++ "A" (str.++ "E" (str.++ "@" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "1" (str.++ "." (str.++ "8" (str.++ "." (str.++ "8" (str.++ ":" (str.++ "9" (str.++ "/" (str.++ "i" "")))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" "")))))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" ""))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range ":" ":") (re.+ (re.union (re.range "$" "&")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (re.range "@" "@"))))(re.++ (re.union (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "1" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))))))))) (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}")) (re.* (re.union (re.range "#" "'")(re.union (re.range "+" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
