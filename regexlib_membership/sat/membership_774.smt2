;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[iI][mM][gG][a-zA-Z0-9\s=".]*((src)=\s*(?:"([^"]*)"|'[^']*'))[a-zA-Z0-9\s=".]*/*>(?:</[iI][mM][gG]>)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F3\x0<ImGsrc=\u0085\u0085\'M\'>\u008B\x16\u00B5\xF"
(define-fun Witness1 () String (str.++ "\u{f3}" (str.++ "\u{00}" (str.++ "<" (str.++ "I" (str.++ "m" (str.++ "G" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "'" (str.++ "M" (str.++ "'" (str.++ ">" (str.++ "\u{8b}" (str.++ "\u{16}" (str.++ "\u{b5}" (str.++ "\u{0f}" "")))))))))))))))))))))
;witness2: "[\u00AE\u00CB<iMg\u0085src= \'\'></imG>~y\u00F7\xB"
(define-fun Witness2 () String (str.++ "[" (str.++ "\u{ae}" (str.++ "\u{cb}" (str.++ "<" (str.++ "i" (str.++ "M" (str.++ "g" (str.++ "\u{85}" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ " " (str.++ "'" (str.++ "'" (str.++ ">" (str.++ "<" (str.++ "/" (str.++ "i" (str.++ "m" (str.++ "G" (str.++ ">" (str.++ "~" (str.++ "y" (str.++ "\u{f7}" (str.++ "\u{0b}" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{22}" "\u{22}")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))(re.++ (re.++ (str.to_re (str.++ "s" (str.++ "r" (str.++ "c" ""))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'")))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{22}" "\u{22}")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))(re.++ (re.* (re.range "/" "/"))(re.++ (re.range ">" ">") (re.* (re.++ (str.to_re (str.++ "<" (str.++ "/" "")))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g")) (re.range ">" ">")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
