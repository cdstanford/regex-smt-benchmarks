;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z].*|[1-9].*|[:./].*)\.(((a|A)(s|S)(p|P)(x|X)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ":[.Aspx"
(define-fun Witness1 () String (seq.++ ":" (seq.++ "[" (seq.++ "." (seq.++ "A" (seq.++ "s" (seq.++ "p" (seq.++ "x" ""))))))))
;witness2: "f0;\u00B6.ASpX"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "0" (seq.++ ";" (seq.++ "\xb6" (seq.++ "." (seq.++ "A" (seq.++ "S" (seq.++ "p" (seq.++ "X" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.union (re.++ (re.range "1" "9") (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))) (re.++ (re.union (re.range "." "/") (re.range ":" ":")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.++ (re.range "." ".")(re.++ (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "X" "X") (re.range "x" "x"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
