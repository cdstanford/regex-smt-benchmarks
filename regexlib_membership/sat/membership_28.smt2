;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+?1[- .]?)?[.\(]?[\d^01]\d{2}\)?[- .]?\d{3}[- .]?\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E9\u00FAE.^94).0329966g"
(define-fun Witness1 () String (str.++ "\u{e9}" (str.++ "\u{fa}" (str.++ "E" (str.++ "." (str.++ "^" (str.++ "9" (str.++ "4" (str.++ ")" (str.++ "." (str.++ "0" (str.++ "3" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "6" (str.++ "g" ""))))))))))))))))))
;witness2: "\u00D3^382327690LD"
(define-fun Witness2 () String (str.++ "\u{d3}" (str.++ "^" (str.++ "3" (str.++ "8" (str.++ "2" (str.++ "3" (str.++ "2" (str.++ "7" (str.++ "6" (str.++ "9" (str.++ "0" (str.++ "L" (str.++ "D" ""))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.opt (re.union (re.range " " " ") (re.range "-" "."))))))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "." ".")))(re.++ (re.union (re.range "0" "9") (re.range "^" "^"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
