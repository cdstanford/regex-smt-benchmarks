;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+27|27)?(\()?0?[87][23467](\))?( |-|\.|_)?(\d{3})( |-|\.|_)?(\d{4})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(727995793"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "7" (seq.++ "2" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "3" "")))))))))))
;witness2: "27(082)8882947\u00C6"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "7" (seq.++ "(" (seq.++ "0" (seq.++ "8" (seq.++ "2" (seq.++ ")" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "4" (seq.++ "7" (seq.++ "\xc6" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "+" (seq.++ "2" (seq.++ "7" "")))) (str.to_re (seq.++ "2" (seq.++ "7" "")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "7" "8")(re.++ (re.union (re.range "2" "4") (re.range "6" "7"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" ".") (re.range "_" "_"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" ".") (re.range "_" "_")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
