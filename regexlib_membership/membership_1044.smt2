;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = e(vi?)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e"
(define-fun Witness1 () String (str.++ "e" ""))
;witness2: "eviO^}c?"
(define-fun Witness2 () String (str.++ "e" (str.++ "v" (str.++ "i" (str.++ "O" (str.++ "^" (str.++ "}" (str.++ "c" (str.++ "?" "")))))))))

(assert (= regexA (re.++ (re.range "e" "e") (re.opt (re.++ (re.range "v" "v") (re.opt (re.range "i" "i")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
