;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[\$Ss]pecia[l1]\W[Oo0]ffer.*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$pecial;0ffer"
(define-fun Witness1 () String (str.++ "$" (str.++ "p" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "a" (str.++ "l" (str.++ ";" (str.++ "0" (str.++ "f" (str.++ "f" (str.++ "e" (str.++ "r" ""))))))))))))))
;witness2: "Specia1=0ffer_"
(define-fun Witness2 () String (str.++ "S" (str.++ "p" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "a" (str.++ "1" (str.++ "=" (str.++ "0" (str.++ "f" (str.++ "f" (str.++ "e" (str.++ "r" (str.++ "_" "")))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "$" "$")(re.union (re.range "S" "S") (re.range "s" "s")))(re.++ (str.to_re (str.++ "p" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "a" ""))))))(re.++ (re.union (re.range "1" "1") (re.range "l" "l"))(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "O" "O") (re.range "o" "o")))(re.++ (str.to_re (str.++ "f" (str.++ "f" (str.++ "e" (str.++ "r" ""))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
