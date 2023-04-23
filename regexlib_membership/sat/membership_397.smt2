;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z].*|[1-9].*|[:./].*)\.(((a|A)(s|S)(p|P)(x|X)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ":[.Aspx"
(define-fun Witness1 () String (str.++ ":" (str.++ "[" (str.++ "." (str.++ "A" (str.++ "s" (str.++ "p" (str.++ "x" ""))))))))
;witness2: "f0;\u00B6.ASpX"
(define-fun Witness2 () String (str.++ "f" (str.++ "0" (str.++ ";" (str.++ "\u{b6}" (str.++ "." (str.++ "A" (str.++ "S" (str.++ "p" (str.++ "X" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.union (re.++ (re.range "1" "9") (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (re.++ (re.union (re.range "." "/") (re.range ":" ":")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))(re.++ (re.range "." ".")(re.++ (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "X" "X") (re.range "x" "x"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
