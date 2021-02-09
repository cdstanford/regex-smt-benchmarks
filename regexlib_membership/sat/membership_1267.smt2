;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '(?<document>.*)'\)(?<path>.*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6\u00ED7\';\u0087\')"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "\xed" (seq.++ "7" (seq.++ "'" (seq.++ ";" (seq.++ "\x87" (seq.++ "'" (seq.++ ")" "")))))))))
;witness2: "K\'\')v\u00C3"
(define-fun Witness2 () String (seq.++ "K" (seq.++ "'" (seq.++ "'" (seq.++ ")" (seq.++ "v" (seq.++ "\xc3" "")))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "'" (seq.++ ")" ""))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
