;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z].*|[1-9].*)\.(((j|J)(p|P)(g|G))|((g|G)(i|I)(f|F)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6\xD.jPG"
(define-fun Witness1 () String (str.++ "6" (str.++ "\u{0d}" (str.++ "." (str.++ "j" (str.++ "P" (str.++ "G" "")))))))
;witness2: "L.gIf"
(define-fun Witness2 () String (str.++ "L" (str.++ "." (str.++ "g" (str.++ "I" (str.++ "f" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "G" "G") (re.range "g" "g")))) (re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.union (re.range "I" "I") (re.range "i" "i")) (re.union (re.range "F" "F") (re.range "f" "f"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
