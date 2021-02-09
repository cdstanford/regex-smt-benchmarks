;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [+-]?(0|[1-9]([0-9]{0,2})(,[0-9]{3})*)(\.[0-9]+)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E2\x50.1"
(define-fun Witness1 () String (seq.++ "\xe2" (seq.++ "\x05" (seq.++ "0" (seq.++ "." (seq.++ "1" ""))))))
;witness2: "\u00B8gi+889,488.29"
(define-fun Witness2 () String (seq.++ "\xb8" (seq.++ "g" (seq.++ "i" (seq.++ "+" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "," (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "9" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.range "0" "0") (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
