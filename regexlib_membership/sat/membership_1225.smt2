;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:[a-zA-Z0-9_'^&amp;/+-])+(?:\.(?:[a-zA-Z0-9_'^&amp;/+-])+)*@(?:(?:\[?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\.){3}(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\]?)|(?:[a-zA-Z0-9-]+\.)+(?:[a-zA-Z]){2,}\.?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "n.+@[106.[255.[94.211]"
(define-fun Witness1 () String (str.++ "n" (str.++ "." (str.++ "+" (str.++ "@" (str.++ "[" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "." (str.++ "[" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "." (str.++ "[" (str.++ "9" (str.++ "4" (str.++ "." (str.++ "2" (str.++ "1" (str.++ "1" (str.++ "]" "")))))))))))))))))))))))
;witness2: ";@[255.255.[247.94"
(define-fun Witness2 () String (str.++ ";" (str.++ "@" (str.++ "[" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "." (str.++ "[" (str.++ "2" (str.++ "4" (str.++ "7" (str.++ "." (str.++ "9" (str.++ "4" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "&" "'")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "^" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "&" "'")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "^" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "[" "["))(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))))(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.opt (re.range "]" "]")))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.opt (re.range "." "."))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
