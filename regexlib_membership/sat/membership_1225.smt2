;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:[a-zA-Z0-9_'^&amp;/+-])+(?:\.(?:[a-zA-Z0-9_'^&amp;/+-])+)*@(?:(?:\[?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\.){3}(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\]?)|(?:[a-zA-Z0-9-]+\.)+(?:[a-zA-Z]){2,}\.?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "n.+@[106.[255.[94.211]"
(define-fun Witness1 () String (seq.++ "n" (seq.++ "." (seq.++ "+" (seq.++ "@" (seq.++ "[" (seq.++ "1" (seq.++ "0" (seq.++ "6" (seq.++ "." (seq.++ "[" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "[" (seq.++ "9" (seq.++ "4" (seq.++ "." (seq.++ "2" (seq.++ "1" (seq.++ "1" (seq.++ "]" "")))))))))))))))))))))))
;witness2: ";@[255.255.[247.94"
(define-fun Witness2 () String (seq.++ ";" (seq.++ "@" (seq.++ "[" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "[" (seq.++ "2" (seq.++ "4" (seq.++ "7" (seq.++ "." (seq.++ "9" (seq.++ "4" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "&" "'")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "^" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "&" "'")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "^" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "[" "["))(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))))(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.opt (re.range "]" "]")))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.opt (re.range "." "."))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
