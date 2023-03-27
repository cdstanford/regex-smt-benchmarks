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

;witness1: "9\u009E\u00CF\u008B]evi"
(define-fun Witness1 () String (str.++ "9" (str.++ "\u{9e}" (str.++ "\u{cf}" (str.++ "\u{8b}" (str.++ "]" (str.++ "e" (str.++ "v" (str.++ "i" "")))))))))
;witness2: "s\u00B5\u00CEe"
(define-fun Witness2 () String (str.++ "s" (str.++ "\u{b5}" (str.++ "\u{ce}" (str.++ "e" "")))))

(assert (= regexA (re.++ (re.range "e" "e") (re.opt (re.++ (re.range "v" "v") (re.opt (re.range "i" "i")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
