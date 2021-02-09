;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^A-?|[BCD][+-]?|[SN]?F|W$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "=\x1Bl2SF"
(define-fun Witness1 () String (seq.++ "=" (seq.++ "\x1b" (seq.++ "l" (seq.++ "2" (seq.++ "S" (seq.++ "F" "")))))))
;witness2: "A\u00AF\u00F8\x13"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "\xaf" (seq.++ "\xf8" (seq.++ "\x13" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "A" "A") (re.opt (re.range "-" "-"))))(re.union (re.++ (re.range "B" "D") (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))))(re.union (re.++ (re.opt (re.union (re.range "N" "N") (re.range "S" "S"))) (re.range "F" "F")) (re.++ (re.range "W" "W") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
