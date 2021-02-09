;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^M{0,1}T{0,1}W{0,1}(TH){0,1}F{0,1}S{0,1}(SU){0,1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "MTTHFSSU"
(define-fun Witness1 () String (seq.++ "M" (seq.++ "T" (seq.++ "T" (seq.++ "H" (seq.++ "F" (seq.++ "S" (seq.++ "S" (seq.++ "U" "")))))))))
;witness2: "MWTHFS"
(define-fun Witness2 () String (seq.++ "M" (seq.++ "W" (seq.++ "T" (seq.++ "H" (seq.++ "F" (seq.++ "S" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "M" "M"))(re.++ (re.opt (re.range "T" "T"))(re.++ (re.opt (re.range "W" "W"))(re.++ (re.opt (str.to_re (seq.++ "T" (seq.++ "H" ""))))(re.++ (re.opt (re.range "F" "F"))(re.++ (re.opt (re.range "S" "S"))(re.++ (re.opt (str.to_re (seq.++ "S" (seq.++ "U" "")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
