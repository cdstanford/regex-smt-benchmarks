;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{(.+)|^\\(.+)|(\}*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{sc\x2"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "s" (seq.++ "c" (seq.++ "\x02" "")))))
;witness2: "{\x1CXD\u00C0\u00F0"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "\x1c" (seq.++ "X" (seq.++ "D" (seq.++ "\xc0" (seq.++ "\xf0" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "{" "{") (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.* (re.range "}" "}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
