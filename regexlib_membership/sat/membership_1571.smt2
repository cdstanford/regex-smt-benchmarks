;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\w(\s)?)+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1C\x109L"
(define-fun Witness1 () String (seq.++ "\x1c" (seq.++ "\x10" (seq.++ "9" (seq.++ "L" "")))))
;witness2: "WN\u0099\u009CB\x5x<"
(define-fun Witness2 () String (seq.++ "W" (seq.++ "N" (seq.++ "\x99" (seq.++ "\x9c" (seq.++ "B" (seq.++ "\x05" (seq.++ "x" (seq.++ "<" "")))))))))

(assert (= regexA (re.+ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
