;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]:\\([^"*/:?|<>\\.\x00-\x20]([^"*/:?|<>\\\x00-\x1F]*[^"*/:?|<>\\.\x00-\x20])?\\)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z:\"
(define-fun Witness1 () String (str.++ "Z" (str.++ ":" (str.++ "\u{5c}" ""))))
;witness2: "E:\"
(define-fun Witness2 () String (str.++ "E" (str.++ ":" (str.++ "\u{5c}" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (str.to_re (str.++ ":" (str.++ "\u{5c}" "")))(re.++ (re.* (re.++ (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))) (re.range "\u{5c}" "\u{5c}")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
