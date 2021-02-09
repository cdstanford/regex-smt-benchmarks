;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (vi(v))?d
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "vivd"
(define-fun Witness1 () String (seq.++ "v" (seq.++ "i" (seq.++ "v" (seq.++ "d" "")))))
;witness2: "d\x4"
(define-fun Witness2 () String (seq.++ "d" (seq.++ "\x04" "")))

(assert (= regexA (re.++ (re.opt (re.++ (str.to_re (seq.++ "v" (seq.++ "i" ""))) (re.range "v" "v"))) (re.range "d" "d"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
