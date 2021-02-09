;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[^"\r\n]*"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"\x0\"\u00C8\u00A4\x3"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "\x00" (seq.++ "\x22" (seq.++ "\xc8" (seq.++ "\xa4" (seq.++ "\x03" "")))))))
;witness2: "\"\"\u00ACh"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\xac" (seq.++ "h" "")))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "!") (re.range "#" "\xff"))))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
