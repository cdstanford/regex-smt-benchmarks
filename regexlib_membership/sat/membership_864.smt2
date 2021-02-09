;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d+(/\d+)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1193/4\x1FUk\u00BB"
(define-fun Witness1 () String (seq.++ "\x11" (seq.++ "9" (seq.++ "3" (seq.++ "/" (seq.++ "4" (seq.++ "\x1f" (seq.++ "U" (seq.++ "k" (seq.++ "\xbb" ""))))))))))
;witness2: "8599/109"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "/" (seq.++ "1" (seq.++ "0" (seq.++ "9" "")))))))))

(assert (= regexA (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (re.range "/" "/") (re.+ (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
