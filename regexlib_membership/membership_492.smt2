;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<\s*(td|TD)\s*(\w|\W)*\s*>(\w|\W)*</(td|TD)>$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<TD\u00A0i\u00B5></TD>"
(define-fun Witness1 () String (str.++ "<" (str.++ "T" (str.++ "D" (str.++ "\u{a0}" (str.++ "i" (str.++ "\u{b5}" (str.++ ">" (str.++ "<" (str.++ "/" (str.++ "T" (str.++ "D" (str.++ ">" "")))))))))))))
;witness2: "<TD \u0085>\u008A</td>"
(define-fun Witness2 () String (str.++ "<" (str.++ "T" (str.++ "D" (str.++ " " (str.++ "\u{85}" (str.++ ">" (str.++ "\u{8a}" (str.++ "<" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ ">" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "t" (str.++ "d" ""))) (str.to_re (str.++ "T" (str.++ "D" ""))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.union (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))) (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))) (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))))(re.++ (str.to_re (str.++ "<" (str.++ "/" "")))(re.++ (re.union (str.to_re (str.++ "t" (str.++ "d" ""))) (str.to_re (str.++ "T" (str.++ "D" ""))))(re.++ (re.range ">" ">") (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
