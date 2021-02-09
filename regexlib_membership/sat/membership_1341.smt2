;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w0-9&#228;&#196;&#246;&#214;&#252;&#220;&#223;\-_]+\.[a-zA-Z0-9]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ca.f6"
(define-fun Witness1 () String (seq.++ "c" (seq.++ "a" (seq.++ "." (seq.++ "f" (seq.++ "6" ""))))))
;witness2: "Q\u00BA#.Zx"
(define-fun Witness2 () String (seq.++ "Q" (seq.++ "\xba" (seq.++ "#" (seq.++ "." (seq.++ "Z" (seq.++ "x" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
