;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\/\/--&gt;\s*)?&lt;\/?SCRIPT([^&gt;]*)&gt;(\s*&lt;!--\s)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "//--&gt; &lt;/SCRIPT&gt;"
(define-fun Witness1 () String (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "-" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ " " (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "S" (str.++ "C" (str.++ "R" (str.++ "I" (str.++ "P" (str.++ "T" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))
;witness2: "\u00B6//--&gt;&lt;SCRIPT\x1F&gt;"
(define-fun Witness2 () String (str.++ "\u{b6}" (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "-" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "S" (str.++ "C" (str.++ "R" (str.++ "I" (str.++ "P" (str.++ "T" (str.++ "\u{1f}" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (str.to_re (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "-" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (str.to_re (str.++ "S" (str.++ "C" (str.++ "R" (str.++ "I" (str.++ "P" (str.++ "T" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))) (re.opt (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "!" (str.++ "-" (str.++ "-" "")))))))) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
