;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+27|27)?(\()?0?[87][23467](\))?( |-|\.|_)?(\d{3})( |-|\.|_)?(\d{4})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(727995793"
(define-fun Witness1 () String (str.++ "(" (str.++ "7" (str.++ "2" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "7" (str.++ "9" (str.++ "3" "")))))))))))
;witness2: "27(082)8882947\u00C6"
(define-fun Witness2 () String (str.++ "2" (str.++ "7" (str.++ "(" (str.++ "0" (str.++ "8" (str.++ "2" (str.++ ")" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "7" (str.++ "\u{c6}" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "+" (str.++ "2" (str.++ "7" "")))) (str.to_re (str.++ "2" (str.++ "7" "")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "7" "8")(re.++ (re.union (re.range "2" "4") (re.range "6" "7"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" ".") (re.range "_" "_"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" ".") (re.range "_" "_")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
