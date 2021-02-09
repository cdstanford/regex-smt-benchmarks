;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+?1[- .]?)?[.\(]?[\d^01]\d{2}\)?[- .]?\d{3}[- .]?\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E9\u00FAE.^94).0329966g"
(define-fun Witness1 () String (seq.++ "\xe9" (seq.++ "\xfa" (seq.++ "E" (seq.++ "." (seq.++ "^" (seq.++ "9" (seq.++ "4" (seq.++ ")" (seq.++ "." (seq.++ "0" (seq.++ "3" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ "g" ""))))))))))))))))))
;witness2: "\u00D3^382327690LD"
(define-fun Witness2 () String (seq.++ "\xd3" (seq.++ "^" (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "3" (seq.++ "2" (seq.++ "7" (seq.++ "6" (seq.++ "9" (seq.++ "0" (seq.++ "L" (seq.++ "D" ""))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.opt (re.union (re.range " " " ") (re.range "-" "."))))))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "." ".")))(re.++ (re.union (re.range "0" "9") (re.range "^" "^"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
